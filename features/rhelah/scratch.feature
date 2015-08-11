Feature:  Scratch test

Background: Atomic hosts are discovered
      Given "all" hosts from dynamic inventory
        and "all" host

  Scenario: Initial RPM list
       When "initial" RPM list is collected
       Then there is a text file with the "initial" RPM list present

  Scenario: Subscribe to production
      When "all" host is auto-subscribed to "stage"
       Then subscription status is ok on "all"
        and "1" entitlement is consumed on "all"

  Scenario: 'atomic host upgrade' is successful
      Given there is "1" atomic host tree deployed
       When atomic host upgrade is successful
       Then there is "2" atomic host tree deployed

  Scenario: Reboot into the new deployment
      Given there is "2" atomic host tree deployed
        and the original atomic version has been recorded
       When wait "30" seconds for "all" to reboot
       Then the current atomic version should not match the original atomic version

  Scenario: Unregister from production
       Then "all" host is unsubscribed and unregistered
        and subscription status is unknown on "all"

  Scenario: Collect the data about the upgraded system
      Given the data collection script is present
       When the data collection script is run
       Then the data collection output file is present

  Scenario: Upgraded RPM list
       When "upgraded" RPM list is collected
       Then there is a text file with the "upgraded" RPM list present
       and the data collection output files are retrieved

