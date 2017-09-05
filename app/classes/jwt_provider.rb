class JwtProvider
  def self.encode(payload, expiration = 3.days.from_now.to_i)
    payload = payload.dup
    payload[:exp] = expiration
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true).first
  rescue
    nil
  end
end
