val string = <minecraft:string>;
val hemp = <betterwithmods:material:3>;

recipes.remove(string)
recipes.addshaped(string,[[hemp,null,null],
                         [null,hemp,null],
                         [null,null,hemp]]);
                         
