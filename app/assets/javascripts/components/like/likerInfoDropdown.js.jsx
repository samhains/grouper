LikerInfoDropDown = React.createClass({
  render(){
    var LikerInfoDropItems = this.props.likers.map(
      function(liker){
        return (<LikerInfoDropItem liker={liker}/>);
    });
    if (this.props.showLikers) {
      return (<div className='panel panel-default likers-dropdown custom-dropdown'>
                {LikerInfoDropItems}
              </div>);
    }
    else {
      return (<span></span>);
    }

  }
});
