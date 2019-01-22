module SignIt # :nodoc:
  class << self
    include Helpers

    def create(access_key, secret_key, message, algorithm = 'sha256',
               prefix = AUTH_PREFIX_HEADER)
      hmac_hex_digest = create_digest(secret_key, message, algorithm)
      format(SIGNATURE_FORMAT, prefix: prefix, access_key: access_key,
                               hmac_hex_digest: hmac_hex_digest)
    end

    def parse(signature)
      prefix, access_key_hmac_digest = signature.split(' ')
      [prefix] + access_key_hmac_digest.split(':')
    end

    def valid?(hmac_hex_digest, secret_key, message, algorithm = 'sha256')
      valid_hmac_hex_digest = create_digest(secret_key, message, algorithm)
      return true if hmac_hex_digest.to_s == valid_hmac_hex_digest.to_s

      false
    end

    def generate(key_length = KEY_LENGTH, key_chars = KEY_CHARS)
      (0...key_length).map do
        key_chars.split('').to_a[Sysrandom.random_number(key_chars.size)]
      end.join
    end
  end
end
