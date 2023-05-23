// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../domain/entities/worker_dto.dart';
import '../domain/usecase/usecase.dart';

class WorkerProvider extends ChangeNotifier {
  GlobalKey<FormState> updateWorkerKey = GlobalKey();
  GlobalKey<FormState> addWorkerKey = GlobalKey();

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) => _isLoading = isLoading;

  bool _isLoadingAction = false;
  bool get isLoadingAction => _isLoadingAction;
  set isLoadingAction(bool isLoadingAction) =>
      _isLoadingAction = isLoadingAction;

  List<WorkerDTO> workers = [];

  final WorkerDTO _clearWorker = WorkerDTO(
      id: '',
      name: '',
      lastname: '',
      email: '',
      phone: '',
      maritalStatus: Constants.single,
      salary: 0,
      age: DateTime.now().subtract(Constants.minAgeWorker).toString(),
      role: Constants.chefValue);

  WorkerDTO _newWorker = WorkerDTO(
      id: '',
      name: '',
      lastname: '',
      email: '',
      phone: '',
      maritalStatus: Constants.single,
      salary: 0,
      age: DateTime.now().subtract(Constants.minAgeWorker).toString(),
      role: Constants.chefValue);

  WorkerDTO get newWorker => _newWorker;
  set newWorker(WorkerDTO worker) => _newWorker = worker;

  WorkerDTO _updatedWorker = WorkerDTO(
      id: '',
      name: '',
      lastname: '',
      email: '',
      phone: '',
      maritalStatus: Constants.single,
      salary: 0,
      age: '',
      role: Constants.chefValue);
  WorkerDTO get updatedWorker => _updatedWorker;
  set updatedWorker(WorkerDTO user) => _updatedWorker = user;

  int _currentWorkerIndex = 0;
  int get currentWorkerIndex => _currentWorkerIndex;
  set currentWorkerIndex(int currentIndex) =>
      _currentWorkerIndex = currentIndex;

  Future loadData() async {
    try {
      isLoading = true;
      notifyListeners();
      workers = await GetAllWorkersUseCase.getAllWorkers();
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      isLoading = false;
      notifyListeners();
    }
  }

  changeRole(String role, WorkerDTO worker) {
    worker.role = role;
    notifyListeners();
  }

  changeMaritalStatus(String maritalStatus, WorkerDTO worker) {
    worker.maritalStatus = maritalStatus;
    notifyListeners();
  }

  Future<int> addWorker() async {
    if (addWorkerKey.currentState!.validate()) {
      try {
        isLoadingAction = true;
        notifyListeners();
        final response =
            json.decode(await AddWorkerUseCase.addWorker(newWorker: newWorker));
        isLoadingAction = false;
        notifyListeners();
        if (response['status'] == 201) {
          newWorker.id = response['data']['_id'];
          workers.add(newWorker);
          newWorker = _clearWorker.copyWith();
        }
        return response['status'];
      } catch (ex) {
        isLoadingAction = false;
        notifyListeners();
        return 500;
      }
    }
    return 1;
  }

  Future<int> updateWorker() async {
    if (updateWorkerKey.currentState!.validate()) {
      if (!updatedWorker.equals(workers[currentWorkerIndex])) {
        try {
          isLoadingAction = true;
          notifyListeners();
          final response = await UpdateWorkerUseCase.updateWorker(
              updatedWorker: updatedWorker);
          isLoadingAction = false;
          notifyListeners();
          if (response == 200) {
            workers[currentWorkerIndex] = updatedWorker;
          }
          return response;
        } catch (ex) {
          isLoadingAction = false;
          notifyListeners();
          return 500;
        }
      } else {
        return 100;
      }
    }
    return 0;
  }

  Future<int> deleteWorker(String id) async {
    try {
      isLoadingAction = true;
      notifyListeners();
      final response = await DeleteWorkerUseCase.deleteWorker(id: id);
      if (response == 200) {
        workers.removeAt(currentWorkerIndex);
      }
      isLoadingAction = false;
      notifyListeners();
      return response;
    } catch (ex) {
      isLoadingAction = false;
      notifyListeners();
      return 500;
    }
  }
}
