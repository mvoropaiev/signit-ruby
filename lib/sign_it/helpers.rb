module SignIt
  module Helpers # :nodoc:
    def bytes(str, encoding = UTF8)
      str.encode(encoding)
    end

    def create_digest(secret_key, message, algorithm)
      digest = OpenSSL::Digest.new(algorithm)
      OpenSSL::HMAC.hexdigest(digest, bytes(secret_key), message)
    end
  end
end
