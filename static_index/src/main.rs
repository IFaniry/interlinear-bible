use actix_files as fs;
use actix_web::{App, HttpServer};
//use actix_web::{middleware, App, HttpServer};

#[actix_rt::main]
async fn main() -> std::io::Result<()> {
    //std::env::set_var("RUST_LOG", "actix_web=info");
    //env_logger::init();

    HttpServer::new(|| {
        App::new()
            // enable logger
            //.wrap(middleware::Logger::default())
            .service(
                // static files
                //public
                fs::Files::new("/", "/public/").index_file("index.html"),
            )
    })
    //.bind("0.0.0.0:80")?
    .bind(format!("0.0.0.0:{}", option_env!("PORT").unwrap_or("80")))?
    .run()
    .await
}
