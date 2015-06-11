Package.describe({
  name: 'lalomartins:template-helpers',
  version: '0.0.1',
  summary: 'Smart template helpers',
  git: 'https://github.com/lalomartins/meteor-smart-template-helpers',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use([
    'tracker',
    'coffeescript',
    'templating',
    'spacebars'
  ]);
  api.use('moment:moment', {weak: true});
  api.addFiles('template-helpers.coffee', 'client');
  api.export('TemplateHelpers');
});
