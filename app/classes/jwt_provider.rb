class JwtProvider
  def self.encode(payload, expiration = 1.hour.from_now)
    payload = payload.dup
    payload[:exp] = expiration.to_i
    token = JWT.encode(payload, Rails.application.secrets.secret_key_base)
    Token.create(value: token)
    token
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true).first
  rescue
    nil
  end
end
