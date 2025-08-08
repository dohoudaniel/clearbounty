;; SIP-010 reputation token
(define-constant contract-owner tx-sender)
(define-fungible-token rep-token)

;; Mint new reputation tokens
(define-public (mint (recipient principal) (amount uint))
  (begin
    (asserts! (is-eq tx-sender contract-owner) (err u1))
    (try! (ft-mint? rep-token amount recipient))
    (ok true)))