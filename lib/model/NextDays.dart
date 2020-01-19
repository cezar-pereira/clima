class NextDay {
  var _day;
  var _temp;
  var _min;
  var _max;
  var _condition;
  var _conditionCod;

  get getDay => _day;

  set setDay(day) {
    this._day = day;
  }

    get getTem => _temp;

  set setTemp(temp) {
    this._temp = temp;
  }

  get getMin => _min;

  set setMin(min) {
    this._min = min;
  }

  get getMax => _max;

  set setMax(_max) {
    this._max = _max;
  }

  get getCondition => _condition;

  set setCondition(condition) {
    this._condition = condition;
  }

    get getConditionCod => _conditionCod;

  set setConditionCod(conditionCod) {
    this._conditionCod = conditionCod;
  }
}
