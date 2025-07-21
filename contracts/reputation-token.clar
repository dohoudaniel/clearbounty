;; SIP-010 reputation token
(define-constant contract-owner tx-sender)
(define-fungible-token rep-token)

;; Mint new reputation tokens
(define-public (mint (recipient principal) (amount uint))
  (asserts (is-eq tx-sender contract-owner) (err u1))
  (ft-mint? rep-token amount recipient)
  (ok true))