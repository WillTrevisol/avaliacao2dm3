import 'package:avaliacao1dm3/data/datasources/local_datasource.dart';
import 'package:avaliacao1dm3/data/repositories/game/game_repository.dart';
import 'package:avaliacao1dm3/domain/entities/game.dart';
import 'package:avaliacao1dm3/utils/result.dart';

class GameRepositoryLocal implements GameRepository {
  GameRepositoryLocal({required this.localDatasource});

  final LocalDatasource localDatasource;

  @override
  Future<Result<Game>> addGame(Game game) async {
    try {
      final result = await localDatasource.create(game.toMap());
      return Result.ok(Game.fromMap(result));
    } catch(_) {
      return Result.error(Exception('Failed to add game'));
    }
  }

  @override
  Future<Result<void>> deleteGame(String id) async {
    try {
      await localDatasource.delete(id);
      return Result<void>.ok(null);
    } catch(e) {
      return Result.error(Exception('Failed to delete game'));
    }
  }

  @override
  Future<Result<Game>> getGameById(String id) async {
    try {
      final result = await localDatasource.readById(id);
      final game = Game.fromMap(result);
      return Result<Game>.ok(game);
    } catch(_) {
      return Result.error(Exception('Game not found'));
    }
  }

  @override
  Future<Result<List<Game>>> getGames() async {
    final result = await localDatasource.read();
    final games = result.map((element) => Game.fromMap(element)).toList();
    return Result<List<Game>>.ok(games);
  }

  @override
  Future<Result<void>> updateGame(Game game) async {
    try {
      await localDatasource.update(
        id: game.id,
        data: game.toMap(),
      );
      return Result<Game>.ok(game);
    } catch(_) {
      return Result.error(Exception('Failed to update game'));
    }
  }

}
