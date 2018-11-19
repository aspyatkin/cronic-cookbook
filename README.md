# cronic-cookbook
Chef cookbook to install [cronic](https://habilis.net/cronic/).

## Usage

In contrast to Chef Supermarket's [cronic](https://supermarket.chef.io/cookbooks/cronic) cookbook, this one is meant to be as simple as possible therefore no integration with `cron` resource is implied.

`cronic` resource should be used to install/uninstall [cronic](https://habilis.net/cronic/) script.

One should check `node.run_state['cronic']['installed']` in their Chef cookbooks so as to detect whether the script is installed.

When installed, `node.
run_state['cronic']['command']` will contain the path to the script (most likely `/usr/local/bin/cronic`), which may be used in `cron` resource declarations.

### Install

```ruby
cronic 'default' do
  action :install
end
```

### Uninstall

```ruby
cronic 'default' do
  action :uninstall
end
```

## License
MIT © [Alexander Pyatkin](https://github.com/aspyatkin)
