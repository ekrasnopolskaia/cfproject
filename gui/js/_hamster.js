var supplyTypes = ["fruits","cereals","nuts"];
var supplyTmpl = _.template(" <tr>\n" +
    "            <th scope=\"row\"><%= index%></th>\n" +
    "            <td><%= supply%></td>\n" +
    "            <td><%= type%></td>\n" +
    "            <td><%= date%></td>\n" +
    "            <td><%= weight%></td>\n" +
    "        </tr>");
$.ajax('/HamsterSupply.json',{
    success: function(response) {
        var supply = response.supply,
            orderedSupply = {},
            breakfast = {}, totalWeight = 0, index = 0;
        if (!_.isNil(supply)) {
            _.each (supplyTypes, function (type) {
                orderedSupply[type] = _.sortBy(supply[type],function (a) {return -1*a.weight;});
                breakfast[type] = _.takeRight(_.sortBy(supply[type],function (a) {return -1 * Date.parse(a.date);},1));
                totalWeight += _.reduce(supply[type],function(r,v,k) {
                   return r + (+v.weight);
                },0);
                totalWeight -= breakfast[type][0].weight;

                
                _.each(orderedSupply[type],function(v) {
                    $('.js-hamster-supply')[0].innerHTML += supplyTmpl({index: index, supply: v.name,type: type, date: (new Date(v.date)).toString(), weight: +v.weight});
                    index += 1;
                });
            });
            
            
            
            
            console.log(orderedSupply);
            console.log(breakfast);
            console.log(totalWeight);
            
        }
    }
});

