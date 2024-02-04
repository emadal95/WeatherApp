enum PreferenceKey { theme, unit, locations, forecastLenght }

enum PreferenceType { string, number, list }

const PreferenceKeyTypes = {
  PreferenceKey.theme: PreferenceType.string,
  PreferenceKey.unit: PreferenceType.string,
  PreferenceKey.locations: PreferenceType.list,
  PreferenceKey.forecastLenght: PreferenceType.number,
};
