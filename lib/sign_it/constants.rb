module SignIt
  AUTH_PREFIX_HEADER = 'HMAC-SHA256'.freeze
  KEY_CHARS = '0123456789' \
              'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze
  KEY_LENGTH = 32
  SIGNATURE_FORMAT = '%{prefix} %{access_key}:%{hmac_hex_digest}'.freeze
  UTF8 = 'utf-8'.freeze
end
