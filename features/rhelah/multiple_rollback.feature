Feature:  Verifies that 'atomic host rollback' can be used multiple times without error

Background: Atomic hosts are discovered
      Given "all" hosts from dynamic inventory
        and "all" hosts can be pinged

  Scenario: 1. Host provisioned and subscribed
       When "all" host is auto-subscribed to "stage"
       Then subscription status is ok on "all"
        and "1" entitlement is consumed on "all"

  Scenario: 2. Upgrade to latest release
      Given get the number of atomic host tree deployed
       When confirm atomic host tree to old version
        And atomic host upgrade is successful
       Then there is "2" atomic host tree deployed

  Scenario: 3. Reboot into new deployment
      Given there is "2" atomic host tree deployed
        and the original atomic version has been recorded
       When wait "30" seconds for "all" to reboot
       Then the current atomic version should not match the original atomic version

  Scenario: 4. Rollback multiple (10) times
      Given there is "2" atomic host tree deployed
        and the original atomic version has been recorded
       When rollback occurs multiple times
       Then there is "2" atomic host tree deployed
        and the current atomic version should match the original atomic version

  Scenario: 5. Rollback once more and reboot
      Given there is "2" atomic host tree deployed
        and the original atomic version has been recorded
       When atomic host rollback is successful
        and wait "30" seconds for "all" to reboot
       Then the current atomic version should not match the original atomic version

  Scenario: 6. Unregister
       Then "all" host is unsubscribed and unregistered
        and subscription status is unknown on "all"

