;; Adapter for external oracles
(define-constant oracle-address 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE)
(define-constant err-invalid-oracle u1)

;; Fetch external judgment
(define-public (fetch-judgment (bounty-id uint))
  (try! (contract-call? oracle-address get-judgment bounty-id))
  (ok true))