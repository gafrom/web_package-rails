# Web packaging for Rails

This gem is a glue to stick underlying [web_package](https://github.com/gafrom/web_package) mechanism into Rails 3+ apps. It provides a way to extend existing routes in Rails application with `.sxg` formats. That is, for each known path `/articles/foo` the library handles `/articles/foo.sxg` path out of the box.

## Required environment variables

For an http exchange to be signed a certificate with a special "CanSignHttpExchanges" extension must be provided. For testing purposes you may use just a self-signed one. Please refer to [web_package docs](https://github.com/gafrom/web_package#ever-thought-of-saving-the-internet-on-a-flash) to create such.

Also, an endpoint must be set up serving the certificate in `application/cert-chain+cbor` format. You can use `gen-certurl` tool from [here](https://github.com/WICG/webpackage/tree/master/go/signedexchange#creating-our-first-signed-exchange) to convert PEM certificate into this format.

Having done the above-said we are ready to assign env vars required to use the gem:
```bash
export SXG_CERT_URL='https://my.cdn.com/cert.cbor' \
       SXG_CERT_PATH='/local/path/to/cert.pem' \
       SXG_PRIV_PATH='/local/path/to/priv.key'
```
Please note, that the variables are fetched during class initialization. And <b>failing to provide valid paths will result in an exception.</b>

## Install

First, please ensure the above environment variables are set up all right.

Next, add the gem into your `Gemfile`:
```ruby
gem 'web_package-rails'
```
And run `bundle install` command.

That's it. Once added, the gem will hook into your Rails initialization process to prepend middleware stack with `WebPackage::Middleware`.

## What is inside

The gem is just a rack middleware comprising a lightweight scanner of request paths for the presence of `.sxg` extension. If found, the path is cleared of it, and modified request url is then passed further down the middleware stack to be handled as if no extension was ever given.

In case `.sxg` extension is not detected - the requests are simply proxied intact.

## Contributing

Fork it, create your feature branch from develop, make changes and create new Pull Request. Please do not forget tests.

## License

Web package for Rails is released under the [MIT License](../master/LICENSE).
