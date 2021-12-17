    #-L "127.0.0.1:4444:127.0.0.1:4444" \     # nginx
    #-L "127.0.0.1:4443:127.0.0.1:4443" \     # nginx
    #-L "127.0.0.1:4245:127.0.0.1:4245" \     # indexer
    #-L "127.0.0.1:4244:127.0.0.1:4244" \     # cloud

function whim-forward
  ssh -f -N \
    -L "127.0.0.1:4264:127.0.0.1:4264" \
    -L "127.0.0.1:4254:127.0.0.1:4254" \
    -L "127.0.0.1:4274:127.0.0.1:4274" \
    -L "127.0.0.1:5432:127.0.0.1:5432" \
    -L "127.0.0.1:5433:127.0.0.1:5433" \
    -L "127.0.0.1:6379:127.0.0.1:6379" \
    -L "127.0.0.1:9090:127.0.0.1:9090" \
    -L "127.0.0.1:9191:127.0.0.1:9191" \
    dg-nix
end

    #-L "127.0.0.1:4274:127.0.0.1:4274" \     # renderer
    #-L "127.0.0.1:4264:127.0.0.1:4264" \     # app
    #-L "127.0.0.1:4244:127.0.0.1:4244" \     # cloud
    #-L "127.0.0.1:4254:127.0.0.1:4254" \     # imager
    #-L "127.0.0.1:4245:127.0.0.1:4245" \     # indexer
    #-L "127.0.0.1:5432:127.0.0.1:5432" \     # postgres
    #-L "127.0.0.1:5433:127.0.0.1:5433" \     # postgres
    #-L "127.0.0.1:6379:127.0.0.1:6379" \     # redis
    #-L "127.0.0.1:9090:127.0.0.1:9090" \     # s3mock
    #-L "127.0.0.1:9191:127.0.0.1:9191" \     # s3mock
