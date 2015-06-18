{:user {:plugins [[cider/cider-nrepl "0.9.0"]
                  [refactor-nrepl "1.1.0-SNAPSHOT"]]
        :dependencies [[alembic "0.3.2"]
                       [org.clojure/tools.nrepl "0.2.10"]]
        :repl-options {:nrepl-middleware
                       [cider.nrepl.middleware.complete/wrap-complete
                        cider.nrepl.middleware.macroexpand/wrap-macroexpand
                        cider.nrepl.middleware.refresh/wrap-refresh]}}}
