trigger S2STaskSharinng on Task (after insert) {
    S2SConnectionHelper.recordShare(trigger.new);
}