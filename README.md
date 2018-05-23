Taiga contrib slack
===================

The Taiga plugin for DingTalk integration.

Installation
------------
### Dev env

#### Taiga Back

Clone the repo and

```bash
  cd taiga-contrib-dingtalk/back
  workon taiga
  pip install -e .
```

Modify in `taiga-back` your `settings/local.py` and include the line:

```python
  INSTALLED_APPS += ["taiga_contrib_dingtalk"]
```

Then run the migrations to generate the new need table:

```bash
  python manage.py migrate taiga_contrib_dingtalk
```

#### Taiga Front

After clone the repo link `dist` in `taiga-front` plugins directory:

```bash
  cd taiga-front/dist
  mkdir -p plugins
  cd plugins
  ln -s ../../../taiga-contrib-dingtalk/front/dist dingtalk
```

Include in your `dist/conf.json` in the `contribPlugins` list the value `"/plugins/dingtalk/dingtalk.json"`:

```json
...
    "contribPlugins": [
        (...)
        "/plugins/dingtalk/dingtalk.json"
    ]
...
```

In the plugin source dir `taiga-contrib-dingtalk/front` run

```bash
npm install -g gulp
npm install
gulp build
```
and use:

- `gulp` to regenerate the source and watch for changes.

How to use
----------

Follow the instructions on our support page [Taiga.io Support > Contrib Plugins > Slack integration](https://tree.taiga.io/support/contrib-plugins/slack-integration/ "Taiga.io Support > Contrib Plugins > Slack integration")
And [Dingtalk robot settings](https://open-doc.dingtalk.com/docs/doc.htm?spm=a219a.7629140.0.0.2xxAkv&treeId=257&articleId=105735&docType=1)
