import { BackendDynamicPluginInstaller } from '@backstage/backend-dynamic-feature-service';
import { createRouter } from '@backstage/plugin-adr-backend';

export const dynamicPluginInstaller: BackendDynamicPluginInstaller = {
  kind: 'legacy',

  router: {
      pluginID: 'adr-backend-wrapper',
      createPlugin(env) {
          return createRouter({
            reader: env.reader,
            cacheClient: env.cache.getClient(),
            logger: env.logger,
          });
      },
  },
};