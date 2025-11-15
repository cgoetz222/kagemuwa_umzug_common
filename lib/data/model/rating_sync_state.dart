enum RatingSyncState {
  idle,          // noch nichts geändert
  localPending,  // lokal geändert, Sync läuft irgendwann
  synced,        // mit Server synchron
  failed,        // letzter Versuch fehlgeschlagen
}

extension RatingSyncStateX on RatingSyncState {
  bool get isBusy => this == RatingSyncState.localPending;
  bool get isError => this == RatingSyncState.failed;
  bool get isDone => this == RatingSyncState.synced;
}