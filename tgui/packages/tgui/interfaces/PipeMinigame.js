import {
  Box,
  Flex,
  Section,
  TimeDisplay,
} from 'tgui-core/components';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

export const PipeMinigame = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    timeleft,
    hack_protocols = [[]],
    games = [[[]]],
    finished_states = [],
  } = data;
  let found_valid = 0;
  return (
    <Window width={450} height={565}>
      <Window.Content>
        <Section title="NOC ACCESSION MATRIX">
          {'[TIME LEFT:  ['}
          <TimeDisplay auto="down" value={timeleft} />
          {']'}
          <Flex direction="row" grow={1}>
            {games.map((game, i) => {
              if (finished_states[i] === 0 && !found_valid) {
                found_valid = 1;
                return (
                  <Section
                    key={i}
                    title={'RIDDLE OF MOON IN PROGRESS [ ' + i + ' ]'}
                    level={2}
                  >
                    <Minigame
                      key={i}
                      array={game}
                      finished={finished_states[i]}
                      minigame_id={i}
                    />
                  </Section>
                );
              } else {
                return null;
              }
            })}
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};

const Minigame = (props, context) => {
  const { act, data } = useBackend(context);
  const { array = [[]], minigame_id = 0 } = props;
  return array.map((arr, i) => (
    <Box key={i}>
      {arr.map((element, j) => (
        <Box
          key={i + '_' + j}
          as="img"
          className="pathway"
          width="50px"
          height="50px"
          src={resolveAsset(element + '.png')}
          onClick={() =>
            act('click', {
              xcord: i,
              ycord: j,
              id: minigame_id,
            })
          }
        />
      ))}
    </Box>
  ));
};
