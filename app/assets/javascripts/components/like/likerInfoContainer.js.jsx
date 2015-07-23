function intersperse(arr, sep) {
    if (arr.length === 0) {
        return [];
    }

    var newArr = arr.slice(1).reduce(function(xs, x, i) {
        return xs.concat([sep, x]);
    }, [arr[0]]);

    if (newArr.length > 2) {
      newArr[newArr.length - 2] = 'and ';
    }
    return newArr;
}

var LikerInfoContainer = React.createClass({
  render(){
    var numOfLikes = this.props.likers.length;
    if(numOfLikes === 0) {
      return (<span></span>);
    }
    else if(numOfLikes > 3) {
      return (<span> 
                <a onClick={this.props.toggleLikers}>{`${numOfLikes} likes`}</a>
             </span>);
    }
    else{

      var likerInfoArr = this.props.likers.map(
        function(liker, index){
          return (
            <LikerInfo liker={liker}/>
          );
        }
      );
      var likeUsers = intersperse(likerInfoArr, ', ');
      
      return (<span >
                <span>{likeUsers}</span>
                <span> like this</span>
              </span>);
    }
  }
});

