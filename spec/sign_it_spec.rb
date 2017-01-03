require 'spec_helper'

describe SignIt do
  it 'has a version number' do
    expect(SignIt::VERSION).not_to be nil
  end

  describe 'secret key' do
    it 'generates default secret key' do
      expect(SignIt.generate.size).to be(32)
    end

    it 'generates a secret key with specific size' do
      expect(SignIt.generate(5).size).to be(5)
    end
  end

  describe 'signature' do
    before(:each) do
      @prefix = 'HMAC-SHA256'
      @access_key = 'my_access_key'
      @secret_key = 'my secret key'
      @message = '1457369891.672671'
      @hmac_digest = '0947c88ce16d078dde4a2aded1fe4627643a378757dccc3428c19569fea99542'
      @full_signature = 'HMAC-SHA256 my_access_key:0947c88ce16d078dde4a2aded1fe4627643a378757dccc3428c19569fea99542'
    end

    it 'generates a signature' do
      expect(
        SignIt.create(@access_key, @secret_key, @message)
      ).to eq(@full_signature)
    end

    it 'parses signature' do
      prefix, access_key, hmac_digest = SignIt.parse(@full_signature)
      expect(
        [prefix, access_key, hmac_digest]
      ).to eq([@prefix, @access_key, @hmac_digest])
    end
  end
end
