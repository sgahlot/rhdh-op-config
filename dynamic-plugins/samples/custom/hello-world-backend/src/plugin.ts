import {
    coreServices,
    createBackendPlugin,
  } from '@backstage/backend-plugin-api';
  import { createRouter } from './service/router';
  
  /**
   * Hello-world backend plugin
   *
   * @public
   */
  export const helloWorldPlugin = createBackendPlugin({
    pluginId: 'helloWorld',     // pluginId shouldn't contain dashes -> http://localhost:7007/api/helloWorld/health
    register(env) {
      env.registerInit({
        deps: {
          logger: coreServices.logger,
          httpRouter: coreServices.httpRouter,
        },
        async init({ httpRouter, logger }) {
          httpRouter.use(
            await createRouter({
              logger
            }),
          );
        },
      });
    },
  });