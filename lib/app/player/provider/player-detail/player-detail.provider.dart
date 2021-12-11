import 'package:cokc/app/config/service/config-base.service.dart';
import 'package:cokc/app/player/provider/player-detail/player-detail.state.dart';
import 'package:cokc/app/player/provider/player/player.provider.dart';
import 'package:cokc/app/player/service/player-base.service.dart';
import 'package:cokc/app/resource/model/resource.model.dart';
import 'package:cokc/app/resource/service/resource-base.service.dart';
import 'package:cokc/app/session/service/session-base.service.dart';
import 'package:cokc/app/stat/enum/stat-code.enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerDetailProvider = StateNotifierProvider.autoDispose((ref) {
  ref.maintainState = true;

  return PlayerDetailProvider(
    sessionService: ref.read(sessionServiceProvider),
    playerService: ref.read(playerServiceProvider),
    configService: ref.read(configServiceProvider),
    resourceService: ref.read(resourceServiceProvider),
    playerProvider: ref.read(playerProvider.notifier),
  );
});

class PlayerDetailProvider extends StateNotifier<PlayerDetailState> {
  SessionBaseService sessionService;
  PlayerBaseService playerService;
  ConfigBaseService configService;
  ResourceBaseService resourceService;
  PlayerProvider playerProvider;

  PlayerDetailProvider({
    required this.sessionService,
    required this.playerService,
    required this.configService,
    required this.resourceService,
    required this.playerProvider,
  }) : super(InitialPlayerDetailState());

  Future getPlayer(String playerId) async {
    try {
      state = LoadingPlayerDetailState();

      final selectedPlayer = await playerService.getById(playerId);
      final statConfigList = await configService.getStatConfigList();
      final resourceList = await resourceService.getAll();
      state = LoadedPlayerDetailState(
        player: selectedPlayer,
        statConfigList: statConfigList,
        resourceList: resourceList,
      );
    } catch (e) {
      state = ErrorPlayerDetailState(message: e.toString());
    }
  }

  Future updateStat(
    String playerId,
    StatCode statCode,
    int statPoint,
    bool isPlayerStat,
  ) async {
    try {
      state = LoadingPlayerDetailState();

      if (isPlayerStat) {
        await playerService.updatePlayerStat(playerId, statCode, statPoint);
      } else {
        await playerService.updateWorkerStat(playerId, statCode, statPoint);
      }

      final selectedPlayer = await playerService.getById(playerId);
      final statConfigList = await configService.getStatConfigList();
      final resourceList = await resourceService.getAll();
      state = LoadedPlayerDetailState(
        player: selectedPlayer,
        statConfigList: statConfigList,
        resourceList: resourceList,
      );
    } catch (e) {
      state = ErrorPlayerDetailState(message: e.toString());
    }
  }

  Future addResource(
    String playerId,
    String workerId,
    ResourceModel model,
  ) async {
    try {
      state = LoadingPlayerDetailState();

      await resourceService.addByPlayerIdAndWorkerId(playerId, workerId, model);

      final selectedPlayer = await playerService.getById(playerId);
      final statConfigList = await configService.getStatConfigList();
      final resourceList = await resourceService.getAll();
      state = LoadedPlayerDetailState(
        player: selectedPlayer,
        statConfigList: statConfigList,
        resourceList: resourceList,
      );
    } catch (e) {
      state = ErrorPlayerDetailState(message: e.toString());
    }
  }

  Future removeResource(
    String playerId,
    String workerId,
    ResourceModel model,
  ) async {
    try {
      state = LoadingPlayerDetailState();

      await resourceService.removeByPlayerIdAndWorkerId(
          playerId, workerId, model.id);

      final selectedPlayer = await playerService.getById(playerId);
      final statConfigList = await configService.getStatConfigList();
      final resourceList = await resourceService.getAll();
      state = LoadedPlayerDetailState(
        player: selectedPlayer,
        statConfigList: statConfigList,
        resourceList: resourceList,
      );
    } catch (e) {
      state = ErrorPlayerDetailState(message: e.toString());
    }
  }

  Future savePlayerDetail(String playerId) async {
    try {
      state = LoadingPlayerDetailState();

      await sessionService.saveSession();
      await playerProvider.getPlayerList();

      final selectedPlayer = await playerService.getById(playerId);
      final statConfigList = await configService.getStatConfigList();
      final resourceList = await resourceService.getAll();

      state = LoadedPlayerDetailState(
        player: selectedPlayer,
        statConfigList: statConfigList,
        resourceList: resourceList,
      );
    } catch (e) {
      state = ErrorPlayerDetailState(message: e.toString());
    }
  }
}
