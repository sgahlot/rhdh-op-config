import {
    coreServices,
    createBackendPlugin,
  } from '@backstage/backend-plugin-api';
  import { createRouter, todoReaderServiceRef } from '@backstage/plugin-todo-backend';
  
  /**
   * Hello-world backend plugin
   *
   * @public
   */
  export const todoPlugin = createBackendPlugin({
    pluginId: 'todo',
    register(env) {
      env.registerInit({
        deps: {
          httpRouter: coreServices.httpRouter,
          todoReaderService: todoReaderServiceRef,
        },
        async init({ httpRouter, todoReaderService }) {
          httpRouter.use(
            await createRouter({
              todoService: todoReaderService
            }),
          );
        },
      });
    },
  });