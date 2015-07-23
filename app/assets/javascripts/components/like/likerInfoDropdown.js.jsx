LikerInfoDropDown = React.createClass({
  render(){
    var LikerInfoDropItems;
    if (this.props.showLikers) {
      LikerInfoDropItems = this.props.likers.map(
        function(liker){
          return (<LikerInfoDropItem liker={liker}/>);
      });
    }

    return (<div >
              {LikerInfoDropItems}
            </div>);
  }
});
