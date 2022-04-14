import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :vegalite_demo, VegaliteDemoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "bgFDA1n+CYh5R5Z3pE7f2luuNm6bLcmNQ17BgLqxnMNrLVMEnCHgpkqJnzZe9IwC",
  server: false

# In test we don't send emails.
config :vegalite_demo, VegaliteDemo.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
