# frozen_string_literal: true

module UrlFakeData
  module_function

  def valid_urls
    %w[
      x.co
      www.example.com.br
      http://localhost:3000
      https://www.example.com/path?query=param#fragment
      ftp://example.org
      sub.domain.example.co.uk:8080
      HTTP://CASE-INSENSITIVE.COM
    ]
  end

  def invalid_urls
    [
      nil,
      'x.c',
      "http://#{'a' * 2001}",
      'ht*tp://invalido.com',
      'http:///caminho.com',
      'http://example..com',
      'http://example.com:porta',
      'invalid-url',
      'example .com',
      'https://<script>alert()</script>',
    ]
  end
end
