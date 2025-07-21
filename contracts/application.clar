;; Manages freelancer applications
(define-map Application
  app-id uint
  (bounty-id uint, applicant principal, message (string-utf8 200), 
  status (enum (pending accepted rejected)))

(define-data-var next-app-id uint u0)

;; Apply to bounty
(define-public (apply (bounty-id uint) (message (string-utf8 200)))
  (let ((app-id (var-get next-app-id)))
  (map-set Application app-id { 
    bounty-id: bounty-id, 
    applicant: tx-sender, 
    message: message, 
    status: pending 
  })
  (var-set next-app-id (+ app-id u1))
  (ok app-id))

;; Approve application
(define-public (approve-application (app-id uint))
  (let ((app (unwrap! (map-get? Application app-id) (err u1)))
  (asserts (is-eq tx-sender contract-owner) (err u2)) ;; Only bounty owner
  (map-set Application app-id (merge app { status: accepted }))
  (ok true))