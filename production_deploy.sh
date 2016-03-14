brunch build --production
MIX_ENV=prod mix phoenix.digest
MIX_ENV=prod mix compile.protocols
service phoenix restart
