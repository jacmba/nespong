;=============================================================================================================
;
; Pong classic game
;
; Jacinto Mba Cantero <github.com/jacmba>
; 2020
;
;=============================================================================================================

  .inesprg 1
  .ineschr 1
  .inesmir 1
  .inesmap 0

  .bank 0
  .org $8000

;--------------------------------------------------------------------------------------------------------------
; Startup code
;--------------------------------------------------------------------------------------------------------------
Reset:
  ; Disable IRQs and decimal mode
  sei
  cld

  ; Disable API IRQ
  ldx #$40
  stx $4017

  ; Setup stack
  ldx #$FF
  txs

  ; Disable NMI, rendering and IRQs
  inx
  stx $2000
  stx $2001
  stx $4010

  bit $2002
  jsr WaitVBlank

; Clear memory
  ldx #$00
  txa
Clearmem:
  sta $0000, x
  sta $0100, x
  sta $0300, x
  sta $0400, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  inx
  bne Clearmem

  ldx #$00
  lda #$FF
ClearVmem: ;Cleanup sprite RAM
  sta $0200, x
  inx
  bne ClearVmem

  jsr Initialize
  jsr WaitVBlank
  nop

PPUSetup:
  lda #%10010000
  sta $2000

  lda #%00010000
  sta $2001