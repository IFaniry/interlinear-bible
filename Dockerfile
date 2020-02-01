FROM rust:1.40 as actixbuilder
COPY static_index/. /usr/src/static_index
WORKDIR /usr/src/static_index
RUN cargo install --path .

FROM cloudfoundry/cflinuxfs3 as bare_cf_static_index
COPY --from=actixbuilder /usr/local/cargo/bin/static_index /usr/local/bin/

# FROM node:alpine as gatsbybuilder
# RUN npm install --global --unsafe-perm=true gatsby-cli
# COPY gatsby-site/. /usr/src/gatsby-site
# WORKDIR /usr/src/gatsby-site
# RUN npm install
# ENV PATH /usr/src/app/node_modules/.bin:$PATH
# RUN gatsby build

FROM gatsbyjs/gatsby-dev-builds as gatsbybuilder
COPY gatsby-site/. /usr/src/gatsby-site
WORKDIR /usr/src/gatsby-site
RUN yarn
RUN gatsby build

FROM bare_cf_static_index as cf_static_index
#EXPOSE 80
# COPY --from=actixbuilder /root/.cargo/bin/static_index /usr/local/bin/
COPY --from=gatsbybuilder /usr/src/gatsby-site/public/. /public
#COPY gatsby-site/public/. /public

#COPY --from=actixbuilder /usr/local/cargo/bin/static_index /usr/local/bin/
ENTRYPOINT [ "static_index" ]
#RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh