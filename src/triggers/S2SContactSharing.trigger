trigger S2SContactSharing on Contact (after insert) {
    S2SConnectionHelper.recordShare(trigger.new);
}