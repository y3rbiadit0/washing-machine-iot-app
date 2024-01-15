// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'washing_machine_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$washingMachinesStreamHash() =>
    r'7f1b39676751a9622ea3c7c6c20ca770641a7475';

/// See also [washingMachinesStream].
@ProviderFor(washingMachinesStream)
final washingMachinesStreamProvider =
    AutoDisposeStreamProvider<List<WashingMachineModel>>.internal(
  washingMachinesStream,
  name: r'washingMachinesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$washingMachinesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WashingMachinesStreamRef
    = AutoDisposeStreamProviderRef<List<WashingMachineModel>>;

String _$reservationsStreamHash() =>
    r'9d050f4d515d0226187ec76f6fb795ba132ed96d';

/// See also [reservationsStream].
@ProviderFor(reservationsStream)
final reservationsStreamProvider =
    AutoDisposeStreamProvider<List<ReservationModel>>.internal(
  reservationsStream,
  name: r'reservationsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reservationsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReservationsStreamRef
    = AutoDisposeStreamProviderRef<List<ReservationModel>>;

String _$washingMachineDoorProviderHash() =>
    r'35801b761beab146fbffa4d3adccef6cf2d6816d';

/// See also [WashingMachineDoorProvider].
@ProviderFor(WashingMachineDoorProvider)
final washingMachineDoorProvider =
    AutoDisposeAsyncNotifierProvider<WashingMachineDoorProvider, void>.internal(
  WashingMachineDoorProvider.new,
  name: r'washingMachineDoorProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$washingMachineDoorProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WashingMachineDoorProvider = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
