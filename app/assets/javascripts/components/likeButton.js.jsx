var LikeButton = React.createClass({
  render(){
    var cx = React.addons.classSet;
    var classes = cx({
      'btn-primary': this.props.liked
    });
    return (
            <button 
              onClick={this.props.clickHandler} 
              className={`btn btn-default btn-xs ${classes}`}>
                <i className="glyphicon glyphicon-thumbs-up"></i>
              Like
            </button>
           );
  }

});
