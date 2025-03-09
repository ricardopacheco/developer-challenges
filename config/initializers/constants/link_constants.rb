# frozen_string_literal: true

LINK_SHORT_CHARACTERS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

URL_REGEX_CONSTANT = %r{
  \A
  (?=.{3,2000}\z)                # Total length (3-2000 characters)
  (?:                            # Optional group for protocol
    (?:(?:https?|ftp):)?\/\/     # Optional protocol (http, https, ftp)
    |                            # OR
    (?:www\.)?                   # Optional www prefix for URLs without protocol
  )?
  (?:                            # Main part of the URL:
    (?:                          # Domain:
      (localhost)                # localhost is allowed
      |                          # OR
      (?:[\p{L}0-9-]+\.)+        # Subdomains (accepts Unicode characters)
      (?:[\p{L}]{2,})            # TLD (min 2 letters, accepts accents)
    )
  )
  (?::\d{2,5})?                  # Optional port
  (?:[/?#][^\s]*)?               # Path, query, or fragment
  \z
}xiu
