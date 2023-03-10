enum KnownDiaryStates {
  /// Diary file doesn't exist.
  doesntExist,

  /// File exists, but is empty completely.
  absolutelyEmpty,

  /// File doesn't exist or exists, but damaged. And user name was provided by user in UI.
  fileIsUselessButUserNameWasProvidedInUI,

  /// Diary file is fullly valid.
  valid
}
