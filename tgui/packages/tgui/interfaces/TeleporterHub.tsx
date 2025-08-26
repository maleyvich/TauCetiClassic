import { useBackend } from '../backend';
import { Button, Box, Divider, Dropdown, Stack } from '../components';
import { Window } from '../layouts';

type Data = {
  regime: string;
  target: string;
  calibration: string;
};

export const Fax = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { regime, target, calibration } = data;

  return (
    <Window width={480} height={320}>
      <Window.Content>
        <Stack width="100%" textAlign="base">
          <Stack.Item grow bold={1}>
            Teleporter Status
          </Stack.Item>
          <Stack.Item>Current Regime: {regime}</Stack.Item>
          <Stack.Item>Current Target: {target}</Stack.Item>
          <Stack.Item>Calibration: {calibration}</Stack.Item>
        </Stack>
        <Stack>
          <Divider />
          <Stack.Item>
            <Button
              icon="eject"
              content={'Set Regime'}
              onClick={() => act('scan')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="eject"
              content={'Set Target'}
              onClick={() => act('scan')}
            />
          </Stack.Item>
        </Stack>
        <Stack>
          <Divider />
          <Stack.Item>
            <Button
              icon="eject"
              content={'Get target from memory'}
              onClick={() => act('scan')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="eject"
              content={'Eject GPS device'}
              onClick={() => act('scan')}
            />
          </Stack.Item>
        </Stack>
        <Box textAlign={'center'} mt={2}>
          <Divider />
          <Button
            icon="fa-solid fa-paper-plane"
            content={'Calibrate Hub'}
            onClick={() => act('send')}
          />
        </Box>
      </Window.Content>
    </Window>
  );
};
