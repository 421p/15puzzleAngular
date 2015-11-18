function getIndex(value, array) {

    for( var i in array) {
        if (value == array[i]) return i;
    }

}
var swap = function(target, i,  array){

        var t = array[i];
        array[i] = array[target];
        array[target] = t;

        return array;
};

(function(){
    'use strict';
    angular
        .module('15p', [])
        .controller("appController", ['$scope', function($scope) {

            $scope.model = {
                cells : (function(){ //лень руками массив прописывать
                    for(var i = 0, a = []; 16 - i; a.push(i++));
                    return a;
                })(),

                shuffle : function(array) {

                    for (var m = array.length, t, i; m ;) {

                        i = Math.floor(Math.random() * m--);

                        t = array[m];
                        array[m] = array[i];
                        array[i] = t;
                    }

                    return array;
                },

                touch : function(e ){

                    var i = getIndex(e.currentTarget.innerHTML, this.cells);

                    if(this.cells[parseInt(i)+1] == 0 && ((parseInt(i)+1) % 4 != 0)) this.cells = swap(parseInt(i)+1, parseInt(i), this.cells);
                    else if(this.cells[parseInt(i)+4] == 0) this.cells = swap(parseInt(i)+4, parseInt(i), this.cells);
                    else if(this.cells[parseInt(i)-1] == 0 && ((parseInt(i)) % 4 != 0)) this.cells = swap(parseInt(i)-1, parseInt(i), this.cells);
                    else if(this.cells[parseInt(i)-4] == 0) this.cells = swap(parseInt(i)-4, parseInt(i), this.cells);

                    (function checkIfWin(cells){
                        var counterOfPeremoga = 0;
                        for(var i in cells){
                            if(parseInt(i)+1 == cells[i]) counterOfPeremoga++;
                        }

                        if(counterOfPeremoga == (cells.length - 1)) alert("Перемога!");
                    })(this.cells);
                },

                triggerWin : function() {
                    this.cells.sort(function(a,b){
                        if(!a) a = $scope.model.cells.length + 1;
                        if(!b) b = $scope.model.cells.length + 1;
                        return a - b;
                    });

                    alert("almost win, проверка на победу сработает при передвижении квадратика");
                }

            };

            for(var i = 0; 3 - i; $scope.model.shuffle($scope.model.cells), i++);

        }]);
})();

