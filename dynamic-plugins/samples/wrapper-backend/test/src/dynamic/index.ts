import {BackendDynamicPluginInstaller} from '@backstage/backend-dynamic-feature-service';
// import {createRouter, GitlabFillerProcessor} from '@immobiliarelabs/backstage-plugin-gitlab-backend';
import {S3Builder} from '@spreadshirt/backstage-plugin-s3-viewer-backend';

export const dynamicPluginInstaller: BackendDynamicPluginInstaller = {
    kind: 'legacy',

    router: {
        pluginID: 'gitlab',
        // createPlugin: createRouter,
        createPlugin(env) {
            return S3Builder.createBuilder({
                config: env.config,
                logger: env.logger,
                scheduler: env.scheduler,
                discovery: env.discovery,
                identity: env.identity,
                permissions: env.permissions,
                tokenManager: env.tokenManager,
              }).build();
        }
    },

    catalog(builder, env) {
        // builder.addProcessor(new GitlabFillerProcessor(env.config));
    },
};
