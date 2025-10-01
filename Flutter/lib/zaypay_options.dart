enum ZayPayStartingDepositMode {
  crypto,
  fiat
}

class ZayPayFiatDepositInitialState {
  final String currency;
  final double amount;

  const ZayPayFiatDepositInitialState({
    required this.currency,
    required this.amount
  });
}

class ZayPayOptions {
  final bool showDepositModeSwitcher;
  final ZayPayStartingDepositMode startingDepositMode;
  final ZayPayFiatDepositInitialState? fiatDepositInitialState;

  const ZayPayOptions({
    this.showDepositModeSwitcher = true,
    this.startingDepositMode = ZayPayStartingDepositMode.crypto,
    this.fiatDepositInitialState
  });
}
