import React, { PureComponent } from 'react';
// import Square from './Square.js';

const Square = function( props ) {
  return (
    <button className={ props.classes } onClick={ props.onClick }>
      { props.value }
    </button>
  );
}

class Board extends PureComponent {
  renderSquare(i) {
    // console.log( i );
    const winningSquares = this.props.winningSquares;
    let classes;
    if ( winningSquares !== undefined && winningSquares.includes( i ) ) {
      classes = "square winning-square";
    }
    else {
      classes = "square";
    }
    return (
      <Square
        value={ this.props.squares[i] }
        onClick={ this.props.onClick.bind( this, i ) }
        classes={ classes }
      />
    );
  }

  render() {
    return (
      <div>
        <div className="board-row">
          { this.renderSquare(0) }
          { this.renderSquare(1) }
          { this.renderSquare(2) }
        </div>
        <div className="board-row">
          { this.renderSquare(3) }
          { this.renderSquare(4) }
          { this.renderSquare(5) }
        </div>
        <div className="board-row">
          { this.renderSquare(6) }
          { this.renderSquare(7) }
          { this.renderSquare(8) }
        </div>
      </div>
    );
  }
}

export default Board;
