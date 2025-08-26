import { useBackend } from '../backend';
import { Button, Box, Divider, Dropdown, Stack } from '../components';
import { Window } from '../layouts';

type Data = {
  regime: string;
  target: string;
  calibration: string;
};

export const TeleporterHub = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { regime, target, calibration } = data;

  return (
    <Window width={480} height={320}>
      <Window.Content>
        <Stack width="100%" vertical mt={1}>
          <Stack.Item grow bold={1}>
            Current Regime:
          </Stack.Item>
          <Stack.Item>
            <Dropdown
              minWidth={12}
              textAlign="base"
              selected={regime}
              options={regime}
              onSelected={(dept) => act('setDestination', { to: dept })}
            />
          </Stack.Item>
          <Stack.Item grow>Current Target: {target}</Stack.Item>
          <Stack.Item grow>Calibration: {calibration}</Stack.Item>
          <Divider />
        </Stack>
        <Stack>
          <Stack.Item>
            <Button
              icon="eject"
              content={'Set Regime'}
              onClick={() => act('regimeset')}
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
        <Stack mt={1}>
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
