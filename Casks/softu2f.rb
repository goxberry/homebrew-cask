cask 'softu2f' do
  version '0.0.17'
  sha256 '5587405776f3249732099059b7e8bc880bf67e7c1647f453ce77b727c0bcd052'

  url "https://github.com/github/SoftU2F/releases/download/#{version}/SoftU2F.pkg"
  appcast 'https://github.com/github/SoftU2F/releases.atom'
  name 'Soft U2F'
  homepage 'https://github.com/github/SoftU2F'

  depends_on macos: '>= :sierra'

  pkg 'SoftU2F.pkg'

  postflight do
    launchd_plist = "#{ENV['HOME']}/Library/LaunchAgents/com.github.SoftU2F.plist"

    system_command '/bin/launchctl',
                   args: ['unload', launchd_plist],
                   sudo: true

    set_ownership launchd_plist

    system_command '/bin/launchctl',
                   args: ['load', launchd_plist]
  end

  uninstall launchctl: 'com.github.SoftU2F',
            kext:      'com.github.SoftU2FDriver',
            pkgutil:   'com.GitHub.SoftU2F'
end
