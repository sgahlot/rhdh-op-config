'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var backstagePluginS3ViewerBackend = require('@spreadshirt/backstage-plugin-s3-viewer-backend');

const dynamicPluginInstaller = {
  kind: "legacy",
  router: {
    pluginID: "gitlab",
    // createPlugin: createRouter,
    createPlugin(env) {
      return backstagePluginS3ViewerBackend.S3Builder.createBuilder({
        config: env.config,
        logger: env.logger,
        scheduler: env.scheduler,
        discovery: env.discovery,
        identity: env.identity,
        permissions: env.permissions,
        tokenManager: env.tokenManager
      }).build();
    }
  },
  catalog(builder, env) {
  }
};

exports.dynamicPluginInstaller = dynamicPluginInstaller;
//# sourceMappingURL=index.cjs.js.map
