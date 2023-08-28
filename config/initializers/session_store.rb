Rails.application.config.session_store :redis_store,
  servers: %w(redis://localhost:6379/0/session),
  key: '_pta_session',
  expire_after: 90.minutes,
  httponly: false 