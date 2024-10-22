## v1.0.0 (2024-10-22)

_Breaking changes_

- Flowpipe `v1.0.0` is now required. For a full list of CLI changes, please see the [Flowpipe v1.0.0 CHANGELOG](https://flowpipe.io/changelog/flowpipe-cli-v1-0-0).
- In Flowpipe configuration files (`.fpc`), `credential` and `credential_import` resources have been renamed to `connection` and `connection_import` respectively.
- Renamed all `cred` params to `conn` and updated their types from `string` to `conn`.

_Enhancements_

- Added `library` to the mod's categories.
- Updated the following pipeline tags:
  - `type = "featured"` to `recommended = "true"`
  - `type = "test"` to `folder = "Tests"`

## v0.1.1 [2024-03-04]

_Bug fixes_

- Fixed invalid type for `license` param in `create_user` pipeline. ([#6](https://github.com/turbot/flowpipe-mod-pagerduty/pull/6))

## v0.1.0 [2023-12-13]

_What's new?_

- Added 15+ pipelines to make it easy to connect your Incident, User resources and more. For usage information and a full list of pipelines, please see [PagerDuty Mod for Flowpipe](https://hub.flowpipe.io/mods/turbot/pagerduty).
